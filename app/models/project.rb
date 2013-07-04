class Project < ActiveRecord::Base
  attr_accessible :build_link, :image_link, :name, :video_link
  before_save :test_quad_links

  validates :name, presence: true, length: { maximum: 50 },uniqueness: { case_sensitive: false }
  validates :category_id, presence: true
  belongs_to :category

  private
    def test_quad_links
      if (!(self.video_link.downcase.include? "http://") && !(self.video_link == ""))
        self.video_link = self.video_link.insert 0, "http://"
      end
      if (!(self.image_link.downcase.include? "http://") && !(self.image_link == ""))
        self.image_link = self.image_link.insert 0, "http://"
      end
      if (!(self.build_link.downcase.include? "http://") && !(self.build_link == ""))
        self.build_link = self.build_link.insert 0, "http://"
      end
    end
end
