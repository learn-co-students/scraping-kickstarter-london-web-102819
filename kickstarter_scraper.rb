# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  project_hash = {}
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)
  projects = kickstarter.css('li.project.grid_4')
  
  projects.each do |p|
    
    project_title = p.css('h2.bbcard_name strong a').text
    image_link = p.css('div.project-thumbnail a img').attribute('src').value
    description = p.css('p.bbcard_blurb').text.slice(1..-2)
    location = p.css('.project-meta a').text.slice(2..-2)
    percent_funded = p.css('ul.project-stats li.first\ funded strong').text[0..-2].to_i
    project_hash[project_title] = {}
    
    project_hash[project_title][:image_link] = image_link
    project_hash[project_title][:description] = description
    project_hash[project_title][:location] = location
    project_hash[project_title][:percent_funded] = percent_funded
  end
  
  project_hash
  
end

#puts create_project_hash
