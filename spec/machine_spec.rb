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
    
    it '\'s state 255 is an inferred non-accepting trap state' do
        machine1 = Machine.new([255],[])
        machine2 = Machine.new([],[])
        machine2.instance_variable_set(:@trap_state, 42)
        expect(machine1.isValid?).to be_falsey
        expect(machine2.isValid?).to be_falsey
    end
end