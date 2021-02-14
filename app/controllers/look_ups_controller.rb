# frozen_string_literal: true

class LookUpsController < ApplicationController
  before_action :set_look_ups, only: [:index]

  def new
    @look_up = LookUp.new
  end

  def create
    @look_up = LookUp.new(look_up_params)

    if @look_up.save
      flash[:notice] = 'Category was successfully created'
      set_look_ups

      redirect_to look_ups_url
    else
      render :new
    end
  end

  def index; end

  private

  def look_up_params
    params.require(:look_up).permit(:group, :name)
  end

  def set_look_ups
    @look_ups = LookUp.all.group_by(&:group)
  end
end
