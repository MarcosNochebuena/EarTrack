class ReportsController < ApplicationController
  def index
    @earrings_by_key = Earring.includes(:key).group_by(&:key_id)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "RegistroAretes_#{Time.current.year}", template: "reports/pdf/list",
              formats: [:html],
              layout: "pdf",
              page_size: "letter"
      end
    end
  end
end
