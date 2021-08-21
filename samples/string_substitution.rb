ORGANISATION_NAME = "Organisation"
GROUP_NAME = "Group"

workspace do
  model do
    enterprise "#{ORGANISATION_NAME} - #{GROUP_NAME}" do
      user = person "User"
    end
  end
end
