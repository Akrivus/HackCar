require 'sinatra'
require 'thread'
require 'date'

set :bind, '0.0.0.0'
set :port,  80

post    '/vel/:x/:y'    do
    'Invalid parameters(s)'
    CAR_MUTEX.synchronize do
        tuple = [params['x'].to_i, params['y'].to_i]
        if VELOCITIES.include? tuple
            CAR[:velx] = tuple[0]
            CAR[:vely] = tuple[1]
            CAR[:kill] = true
            'Velocity set.'
        end
    end
end
put     '/vel/x/:x'     do
    'Invalid parameters(s).'
    CAR_MUTEX.synchronize do
        tuple = [params['x'].to_i, CAR[:vely]]
        if VELOCITIES.include? tuple
            CAR[:velx] = tuple[0]
            CAR[:kill] = true
            'Velocity set.'
        end
    end
end
put     '/vel/y/:y'     do
    'Invalid parameters(s).'
    CAR_MUTEX.synchronize do
        tuple = [CAR[:velx], params['y'].to_i]
        if VELOCITIES.include? tuple
            CAR[:vely] = tuple[1]
            CAR[:kill] = true
            'Velocity set.'
        end
    end
end
get     '/'             do
%Q(
Current Time: #{DateTime.now}
Driving Time: #{StartTime}
Driving Duration: #{(DateTime.now - StartTime).to_f * 24.0 * 60.0} minutes

Current Velocity: #{CAR[:velx]}, #{CAR[:vely]}
Coordinates: #{CAR[:posx]}, #{CAR[:posy]}
Distance (from origin): #{(CAR[:posx] + CAR[:posy]).abs.to_f / 2.0}    
Current State:
    #{CAR[:vely] == 1 ? 'Moving forward' : (CAR[:vely] == -1 ? 'Moving backward' : '')}
    #{CAR[:velx] == 1 ? 'Turning right' : (CAR[:velx] == -1 ? 'Turning left' : '')}
)
end

StartTime = DateTime.now
VELOCITIES = [
    [-1, -1],
    [-1,  0],
    [-1,  1],
    [ 0, -1],
    [ 0,  0],
    [ 0,  1],
    [ 1, -1],
    [ 1,  0],
    [ 1,  1]
]
CAR_MUTEX = Mutex.new()
CAR = {
    kill: false,
    velx: 0,
    vely: 0,
    posx: 0,
    posy: 0
}

def update
    loop do
        CAR_MUTEX.synchronize do
            if CAR[:kill]
                system('sudo killall nc sox')
                case CAR[:velx]
                when -1
                    Thread.new { system('sox -t wav ./states/left.wav -t wav -r 48k -b 16 - repeat 1 | nc localhost 7099') }
                when  1
                    Thread.new { system('sox -t wav ./states/right.wav -t wav -r 48k -b 16 - repeat 1 | nc localhost 7099') }
                end
                case CAR[:vely]
                when -1
                    Thread.new { system('sox -t wav ./states/reverse.wav -t wav -r 48k -b 16 - repeat 1 | nc localhost 7099') }
                when  1
                    Thread.new { system('sox -t wav ./states/forward.wav -t wav -r 48k -b 16 - repeat 1 | nc localhost 7099') }
                end
                CAR[:kill] = false
            end
            CAR[:posx] += velocity[0]
            CAR[:posy] += velocity[1]
        end
        sleep 0.0
    end
end

Thread.new { system('ncat -klp 7099 -c "csdr convert_i16_f | csdr gain_ff 1 | csdr dsb_fc | sudo ../rpitx/rpitx -i - -m IQFLOAT -f 27.145e3 -s 48000"') }
Thread.new { update }