# frozen_string_literal: true

class FormsController < ApplicationController
  def new
    @form = current_user.forms.new
  end

  def create
    @form = current_user.forms.new(form_params)
    if @form.save
      redirect_to @form
    else
      render "new"
    end
  end

  def show
    @form = current_user.forms.find(params[:id])
  end

  private
    def form_params
      params.require(:form).permit(:name, :domain, :redirect_url)
    end
end
