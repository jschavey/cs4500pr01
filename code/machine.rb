class Machine
    def initialize accept_states, transition_rules
        @accept_states = accept_states
        @start_state = 0
        @transition_rules = transition_rules
        @trap_state = 255
        @states = @accept_states.push(@start_state, @trap_state)
    end
    
    def isValid?
        if @start_state != 0 then 
            false
        elsif @states.count > 256 then
            false
        else
            true
        end
    end
end