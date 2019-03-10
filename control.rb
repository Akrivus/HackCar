# The length of a phase and a verbose way of determining which phase the execution
# cycle is currently operating on.
PHASE_TIME = 0.25
PHASE_REST = false
PHASE_DUTY = true

# The 'xphase' is the phase in the current execution cycle. When false, the
# control payload is being processed and populated by the accessor, and when
# true, the payload is being enacted and cleared for a secondary
$xphase = false

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
        $xphase and true
    else
        $xphase and false
    end
end

# This is the execution cycle itself.
Thread.new { loop do
    $xphase = PHASE_REST
    sleep     PHASE_TIME
    $xphase = PHASE_DUTY
    $vector = $control_vector
    if VECTOR_TYPES.include? $vector
        system("cat ./dir/#{$vector}.wav | csdr convert_i16_f | csdr gain_ff 4.0 | sudo ../rpitx/rpitx -i - -m IQFLOAT -f 27.0633e3 -s 44100")
        system("clear")
    end
    puts "Resting..."
end }