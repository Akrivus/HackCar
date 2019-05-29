require 'sinatra'
require 'thread'

set :bind, '0.0.0.0'
set :port,  80

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
        sleep 0.03
    end
end

post 'vel/:x/:y' do
    CAR_MUTEX.synchronize do
        tuple = [params['x'].to_i, params['y'].to_i]
        if VELOCITIES.include? tuple
            CAR[:velx] = tuple[0]
            CAR[:vely] = tuple[1]
        end
    end
end
put  'vel/x/:x'  do
    CAR_MUTEX.synchronize do
        tuple = [params['x'].to_i, CAR[:vely]]
        if VELOCITIES.include? tuple
            CAR[:velx] = tuple[0]
        end
    end
end
put  'vel/y/:y'  do
    CAR_MUTEX.synchronize do
        tuple = [CAR[:velx], params['y'].to_i]
        if VELOCITIES.include? tuple
            CAR[:vely] = tuple[1]
        end
    end
end

Thread.new { update }