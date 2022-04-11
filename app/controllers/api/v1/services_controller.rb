module Api
  module V1
    class ServicesController < Api::V1::ApiController
      helper_method :user
      skip_before_action :authenticate_user!
      #Search List

      def fetch_services #For product search
        begin
        if params[:q].present?
          @services = Service.where("LOWER(title) LIKE LOWER(?)", "%#{params[:q]}%").page params[:page]
        else
          @services = Service.all.order(title: :asc).page params[:page]
        end

        if I18n.locale.to_s == "ar"
          @services.each do |pr|
            pr.description = pr.ar_description
            pr.title = pr.ar_title
          end
        end

        render json: {api_status: true, locale: I18n.locale.to_s, services: @services}
        rescue => e
          render json: {api_status: false, locale: I18n.locale.to_s, services: @services}
        end
      end



      def show_service
        begin
           unless params[:id].present?
             return  display_error("Product ID is missing!")
           end
          if params[:id].present?
            @service = Service.find(params[:id])
            return display_error("Product Not Present ")  unless @service.present?
          end

           if I18n.locale.to_s == "ar"
             @service.description = @service.ar_description
             @service.title = @service.ar_title
           end

           return render json: {api_status: true, locale: I18n.locale.to_s, service: @service}
        rescue => e
          return display_error("Something Went Wrong!")
        end
      end


      private

        def user
        @user ||= current_user
      end

    end
  end
end