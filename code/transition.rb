class Transition
    attr_reader :current_state, :input_char, :end_state
    
    def initialize rule_string
        array = rule_string.split(',')
        @current_state = array[0].to_i
        @input_char = array[1]
        @end_state = array[2].to_i
    end
end