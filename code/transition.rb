class Transition
    attr_reader :current_state, :input_char, :new_state
    
    def initialize rule_string
        array = rule_string.split(',')
        @current_state = array[0]
        @input_char = array[1]
        @new_state = array[2]
    end
end