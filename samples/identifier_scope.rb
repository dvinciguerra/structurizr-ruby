workspace do
  model do
    software_system1 = software_system "Software System 1" do
      api = container "API"
    end

    software_system2 = software_system "Software System 2" do
      api = container "API"
    end
  end
end
