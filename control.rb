# ARGV[0] is the frequency in MHz, ARGV[1] is the amp rate.
if ARGV[0].nil?
    ARGV[0] = "27.07"
    ARGV[1] = "4.0"
elsif ARGV[1].nil?
    ARGV[1] = "4.0"
end

# The control vector is a set of commands used to determine which signals to
# transmit to the vehicle in manipulating its yaw and acceleration.
$control_vector = '_a'
VECTOR_TYPES = [
    '__',       # BRAKE     STRAIGHT
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
        $control_vector = params['vector']
    end
end

# This is the execution cycle itself.
Thread.new { loop do
    $vector = $control_vector
    if VECTOR_TYPES.include? $vector
        puts system("sox './dir/#{vector}.wav' -t wav -r 48k -b 16 - | csdr convert_i16_f | csdr gain_ff #{ARGV[1]} | sudo ../rpitx/rpitx -i - -m IQFLOAT -f #{ARGV[0]}e3 -s 48000")
        system("clear")
    end
end }