require 'sinatra'
require 'thread'

set :bind, '0.0.0.0'
set :port,  80

CAR_MUTEX = Mutex.new()
CAR = {
    turn: :reset,
    move: :reset,
    dist:  0,
    posx:  0,
    posy:  0
}

def update
    CAR_MUTEX.synchronize do
        case CAR[:move]
        when :forward
            system('sh ./set-car-vector.sh forward >/dev/null')
        when :reverse
            system('sh ./set-car-vector.sh reverse >/dev/null')
        end
        case CAR[:turn]
        when :right
            system('sh ./set-car-vector.sh right >/dev/null')
        when :left
            system('sh ./set-car-vector.sh left >/dev/null')
        end
    end
    sleep 0.03
end
def move(vel)
    CAR_MUTEX.synchronize do
        CAR[:move] = vel
    end
end
def turn(dir)
    CAR_MUTEX.synchronize do
        CAR[:turn] = dir
    end
end

put '/turn/right' do
    turn :right
end
put '/turn/reset' do
    turn :reset
end
put '/turn/left' do
    turn :left
end
put '/turn/*' do

end

put '/move/forward' do
    move :forward
end
put '/move/reset' do
    move :reset
end
put '/move/reverse' do
    move :reverse
end
put '/move/*' do
    
end

get '/turn' do

end
get '/move' do

end

