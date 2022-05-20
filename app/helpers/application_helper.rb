module ApplicationHelper

    def full_title page_title = ""
        base_title =  "Ruby on Rails Tutorial Sample App"
        page_title.empty? ? base_title : "#{page_title} | #{base_title}"
    end

    
    def total_quantity
        quantity = 0
        self.bills.each do |bill|
          quantity += bill.quantity
        end
        return quantity
    end
end
