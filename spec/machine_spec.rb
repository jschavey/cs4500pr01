require_relative '../code/machine'

RSpec.describe Machine do
    it 'has start state 0' do
        machine = Machine.new([], [])
        machine.instance_variable_set(:@start_state, 42)
        expect(machine.isValid?).to be_falsey
    end
    
    it 'has at most 256 states' do
        too_many_states = (1...300).to_a
        machine = Machine.new(too_many_states,[])
        expect(machine.isValid?).to be_falsey
    end
    
    it 'need not have states organized sequentially' do
        states = [30,1,6,42]
        machine = Machine.new(states,[])
        expect(machine.isValid?).to be_truthy
    end
    
    it 'state 255 is an inferred non-accepting trap state' do
        machine1 = Machine.new([255],[])
        machine2 = Machine.new([],[])
        machine2.instance_variable_set(:@trap_state, 42)
        expect(machine1.isValid?).to be_falsey
        expect(machine2.isValid?).to be_falsey
    end
    
    it 'The input alphabet consists of all of the printing characters.' do
        machine = Machine.new([],['0, ,255','255,1,255'])
        machine.instance_variable_get(:@transition_rules).each do |transition|
            expect(transition).to be_a Transition
            expect(machine.instance_variable_get(:@alphabet).include? transition.input_char).to be_truthy 
        end
        machine.instance_variable_get(:@alphabet).each do |character|
            expect(machine.instance_variable_get(:@transition_rules).find(false) { |e| e.input_char == character })
        end
    end
end