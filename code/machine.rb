require_relative 'transition'

class Machine
    def initialize accept_states, transition_rules
        @accept_states = accept_states
        @alphabet = []
        @start_state = 0
        @states = @accept_states + [@start_state]
        @transition_rules = []
        transition_rules.each do |string| 
            transition = Transition.new(string)
            @transition_rules.push(transition)
            if !@alphabet.include? transition.input_char then
                @alphabet.push transition.input_char
            end
            @states.push transition.current_state, transition.end_state
        end
        @trap_state = 255
        @states.push @trap_state
        @states.uniq!
    end
    
    def isValid?
        if @start_state != 0 then 
            false
        elsif @states.count > 256 then
            false
        elsif @trap_state != 255 then
            false
        elsif @accept_states.include? 255 then
            false
        else
            true
        end
    end
end