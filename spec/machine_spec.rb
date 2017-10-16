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
end