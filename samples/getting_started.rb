# frozen_string_literal: true

workspace do
  system = nil

  model do
    user = person "User"
    system = software_system "Software System"

    user.point_to system, label: "Uses"
  end

  views do |view|
    system_context system do |context|
      context.includes :all
      context.auto_layout
    end

    view.theme :default
  end
end
