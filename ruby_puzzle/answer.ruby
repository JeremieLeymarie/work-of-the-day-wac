# CODING GAME prompt: https://www.codingame.com/training/easy/equivalent-resistance-circuit-building

n = gets.to_i

resistors = {}

n.times do
  name, r = gets.split(" ")
  r = r.to_i
  resistors[name] = r
end

circuit = gets.chomp
values = [[]]
currentIndexInValuesArray = 0
currentResistorKey = ""

resistors.each do |key, value|
  circuit = circuit.gsub!(key, value.to_s)
end
circuit = circuit.split(" ")

def computeFirstScope(circuit)
  circuitCopy = circuit.map(&:clone)
  i = circuitCopy.length - 1
  lastClosingSymbolIndex = nil
  values = []
  computedValues = nil

  while i >= 0
    if [")", "]"].include?(circuitCopy[i])
      values = []
      lastClosingSymbolIndex = i
    elsif ["(", "["].include?(circuitCopy[i])
      if circuitCopy[i] == "("
        computedValues = values.inject(:+)
      else
        computedValues = 1.to_f / values.map { |value| 1.to_f / value }.inject(:+)
      end
      break
    else
      values.append(circuitCopy[i].to_f)
    end
    i -= 1
  end

  circuitCopy[i..lastClosingSymbolIndex] = computedValues
  return circuitCopy
end

while circuit.length > 1
  circuit = computeFirstScope(circuit)
end

puts "%.1f" % circuit[0]
