# ARGV[0] is the frequency in MHz, ARGV[1] is the amp rate.
if ARGV[0].nil?
    ARGV[0] = "27.07"
    ARGV[1] = "4.0"
elsif ARGV[1].nil?
    ARGV[1] = "4.0"
end

# The control vector is a set of commands used to determine which signals to
# transmit to the vehicle in manipulating its yaw and acceleration.
VECTOR_TYPES = [
   #'__',       # BRAKE     STRAIGHT
    '_a',       # BRAKE     LEFT
    '_d',       # BRAKE     RIGHT
    's_',       # BACK      STRAIGHT
    'sa',       # BACK      LEFT
    'sd',       # BACK      RIGHT
    'w_',       # FORTH     STRAIGHT
    'wa',       # FORTH     LEFT
    'wd'        # FORTH     RIGHT
]

# For the sake of balancing simplicity and efficiency, we utilize Sinatra,
# which is effectively a socket server (asynchronously) parsing raw HTTP
# requests with an extremely lightweight middleware.
require 'sinatra'

set :bind, '0.0.0.0'
set :port,  4567

# We have 1 axis of movement and 1 axis of rotation, we enumerate these
# with the WASD right-handed T-mapping utilized often in gaming.
put '/' do
    if VECTOR_TYPES.include? params['vector']
        $tx = Thread.new { system("(while true; do sox './dir/#{params['vector']}.wav' -t wav -r 48000 -b 16 - repeat 30; done) | csdr convert_i16_f | csdr gain_ff #{ARGV[1]} | csdr dsb_fc | sudo ../rpitx/rpitx -i - -m IQFLOAT -f #{ARGV[0]}e3 -s 48000") }
    else
        $tx = nil
    end
end