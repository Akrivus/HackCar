require 'sinatra'
require 'thread'
require 'date'

set :bind, '0.0.0.0'
set :port,  80

post    '/vel/:x/:y'    do
    CAR_MUTEX.synchronize do
        tuple = [params['x'].to_i, params['y'].to_i]
        if VELOCITIES.include? tuple
            CAR[:velx] = tuple[0]
            CAR[:vely] = tuple[1]
        end
    end
end
put     '/vel/x/:x'     do
    CAR_MUTEX.synchronize do
        tuple = [params['x'].to_i, CAR[:vely]]
        if VELOCITIES.include? tuple
            CAR[:velx] = tuple[0]
        end
    end
end
put     '/vel/y/:y'     do
    CAR_MUTEX.synchronize do
        tuple = [CAR[:velx], params['y'].to_i]
        if VELOCITIES.include? tuple
            CAR[:vely] = tuple[1]
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
    velx: 0,
    vely: 0,
    posx: 0,
    posy: 0
}

def update
    loop do
        CAR_MUTEX.synchronize do
            CAR[:posx] += CAR[:velx]
            CAR[:posy] += CAR[:vely]
            case CAR[:vely]
            when -1
                system('sh ./set-car-vector.sh reverse >/dev/null')
            when  1
                system('sh ./set-car-vector.sh forward >/dev/null')
            end
            case CAR[:velx]
            when -1
                system('sh ./set-car-vector.sh left >/dev/null')
            when  1
                system('sh ./set-car-vector.sh right >/dev/null')
            end
        end
        sleep 0.02
    end
end

Thread.new { update }