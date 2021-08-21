# frozen_string_literal: true

workspace do
  system = nil

  model do
    user = person "User"
    system = software_system "Software System" do
      webapp = container "Web Application" do |webapp_container|
        user.point_to webapp_container, label: "Uses"
      end

      container "Database" do |database_container|
        webapp.point_to database_container, label: "Reads from and writes to"
      end
    end
  end

  views do |view|
    system_context system do |context|
      context.includes :all
      context.auto_layout :lr
    end

    container system do |context|
      context.includes :all
      context.auto_layout :lr
    end

    view.theme :default
  end
end
