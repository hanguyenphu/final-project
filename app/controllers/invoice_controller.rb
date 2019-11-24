class InvoiceController < ApplicationController
  def index
    @user = current_user
    @invoices = Invoice.where('user_id = ?', @user.id)
    
  end

  def show
    @user = current_user
    @order_id = params[:id]
    @invoice = Invoice.where("id = ? and user_id = ?", @order_id, @user.id).first
    @items = @invoice.solditems.all
  end
end
