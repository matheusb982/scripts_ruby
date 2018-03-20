desc "circ"

task :upd_circ => :environment do
  break_panels = BreakPanel.all

  break_panels.each do |break_panel|
    graph_hours_loads_total1(break_panel.id)
    #power_average(break_panel.id, 0)
  end
end

def graph_hours_loads_total1(id)

  current_hour = Time.now-3.hours
  last_one_hour = current_hour - 1.hours
  less_seconds = current_hour - 30.seconds

  puts current_hour
  puts last_one_hour
  puts less_seconds
  puts '----'

  circuits = Circuit.where(break_panel_id: id).where(wind: false).where(solar: false)

  array_circuit = []
  instan_circ = []

  # circuits.map {|i| array_circuit << i.id }
  # last_circ = array_circuit.sort
  #
  # (0..last_circ+1).map {|i| instan_circ[i] << 0}

  instany_circuit_measure = InstantCircuitMeasure.where("timestamp >= ?", last_one_hour)


  circuits.each do |circuit|
    puts circuit.id
    instan_circ[circuit.id] = instany_circuit_measure.where(circuit_id: circuit.id)
  end

  puts '---'

  # circuits.each do |circuit|
  #   # puts circuit.id
  #   puts instan_circ[circuit.id].last.id
  # end

  puts '*******'
  control_hours_seconds = last_one_hour

  while (control_hours_seconds < current_hour)
    #puts control_hours_seconds
    control_hour = control_hours_seconds += 30.seconds

    ins = instany_circuit_measure.where("timestamp >= ?", last_one_hour).where("timestamp < ?", control_hour)

    if ins.last
      puts ins.last.timestamp
      puts '--'
      puts ins.first.timestamp
    end

    last_one_hour += 30.seconds
  end

end
