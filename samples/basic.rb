# frozen_string_literal: true
#
workspace "Getting Started", "This is a model of my software system." do
  user = nil
  system = nil

  model do
    user = person "User", "A user of my software system."
    system = software_system "Software System", "My software system."

    user.point_to system, label: "Uses"
  end

  views do
    system_context system, "SystemContext", "An example of a System Context diagram." do |context|
      context.includes :all
      context.auto_layout
    end

    styles do
      element "Software System" do |e|
        e.background "#1168bd"
        e.color "#ffffff"
      end

      element "Person" do |e|
        e.shape :person
        e.background "#08427b"
        e.color "#ffffff"
      end
    end
  end
end
