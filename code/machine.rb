require_relative 'transition'

class Machine
    def initialize accept_states, transition_rules
        @accept_states = accept_states
        @alphabet = []
        @start_state = 0
        @current_state = @start_state
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
        #@alphabet.uniq!
        @trap_state = 255
        #@states.push @trap_state
        @states.uniq!
    end
    
    # given a string return true or false if in the language or not
    def decide string
        string.each_char do |c|
            if !@alphabet.include? c then
                return false
            end
            transition = false
            @transition_rules.each do |rule|
                if rule.input_char === c && rule.current_state === @current_state then
                    transition = rule
                    break
                end
            end
            if !transition then 
                return false
            else
                @current_state = transition.end_state
            end
        end

        if @accept_states.include? @current_state then
            return true
        else
            return false
        end
    end
    
    # per instruction
    # is true if is valid automaton 
    #  and has epsilon transitions
    #  or has multiple transitions with the same current_state and input_char
    def isNFA?
        if isValid? then 
            if @alphabet.include? "" then
                return true
            else
                combo = []
                @transition_rules.each do |transition|
                    combo.push([transition.current_state, transition.input_char])
                    if combo.count != combo.uniq.count then
                        return true 
                    end
                end
            end
        end
        return false
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
    
    def type
        if !isValid? then
            return "INVALID"
        elsif isNFA? then
            return "NFA"
        else
            return "DFA"
        end
    end
end