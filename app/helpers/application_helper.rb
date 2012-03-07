module ApplicationHelper
  def title
    base_title = "Roshambo"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  def links
    msg = ""
    links = ["rock", "paper", "scissors"]
    links.each { |link| msg += "<a href=\"/throw/#{link}\">#{link}</a>, " }
    msg += "or <a href=\"/stats/\">view stats</a>."
    return msg
  end
end
