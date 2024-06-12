class GroceryListItemsController < ApplicationController
  def update
    @list_item = GroceryListItem.find(params[:id])
    @list = GroceryList.find(params[:grocery_list_id])
    @list_item.update(items_params)

    respond_to do |format|
      format.html { redirect_to grocery_lists_path}
      format.text { render partial: "grocery_lists/form", locals: { grocery_list: @list, item: @list_item }, formats: [:html] }
    end
  end

  private

  def items_params
    params.require(:grocery_list_item).permit(:bought)
  end
end
