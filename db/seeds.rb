10.times do
  Passage.create!({
    departure_port: "Some departure port",
    arrival_port: "Some arrival port",
    departure_date: Date.today-100,
    arrival_date: Date.today-90,
    description: "A really awesome passage. We left from here and arrived there. The weather was rough.",
    miles: 150,
    hours: 20,
    night_hours: 10,
    role: "Crew",
    overnight: true,
    tidal: true,
    ocean_passage: false
  })
end
