class Part < ActiveRecord::Base
  attr_accessible :cost, :link, :name, :project_id, :quantity, :remote_ip
  before_save :test_part_link

	belongs_to :project

  private
    def test_part_link
      if (!(self.link.downcase.include? "http://") && !(self.link == ""))
        self.link = self.link.insert 0, "http://"
      end
	end
end
