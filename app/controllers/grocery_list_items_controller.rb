class GroceryListItemsController < ApplicationController
  def update
    @list_item = GroceryListItem.find(params[:id])
    @list = GroceryList.find(params[:grocery_list_id])
    @list_item.update(items_params)
    redirect_to grocery_lists_path
  end

  private

  def items_params
    params.require(:grocery_list_item).permit(:bought)
  end
end
