require_relative "machine"

(0...15).each do |i|
    num = i.to_s.rjust(2, '0')
    count = 0
    states = ""
    transitions = Array.new
    accept_file = File.open("results/fa#{num}.acc", "w")
    reject_file = File.open("results/fa#{num}.rej", "w")
    File.readlines("data/fa#{num}.fa").each do |line|
        if count === 0 then
            states = line
        else
            transitions.push line
        end
        count += 1
    end
    
    input_strings = Array.new
    File.readlines("data/fa#{num}.in").each do |line|
        input_strings.push line
    end
    
    states.delete! "{}"
    states = states.split(",").map(&:to_i)

    machine = Machine.new states, transitions
    
    log_file = File.open "results/fa#{num}.log", "w"
    log_file.puts "Alphabet: [#{machine.instance_variable_get("@alphabet").join}]"
    log_file.puts "States: #{machine.instance_variable_get("@states").count}"
    log_file.puts "Valid: #{machine.type}"
    
    if !machine.isValid? || machine.isNFA? then next end    # per instruction, skip invalids or NFAs
    
    log_file.puts "Strings: #{input_strings.count}"
    
    accepted = 0
    rejected = 0
    
    input_strings.each do |string|
        if machine.decide string then
            accept_file.puts string
            accepted += 1
        else
            reject_file.puts string
            rejected += 1
        end
    end
    
    log_file.puts "Accepted: #{accepted}"
    log_file.puts "Rejected: #{rejected}"
end