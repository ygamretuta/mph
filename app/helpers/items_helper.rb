module ItemsHelper
  def get_transaction_button(item, user)
    if item.can_be_reserved_by?(user) && item.is_for_sale?
      link_to 'Reserve', new_user_item_transaction_path(current_user, item), class:'button alert tiny'
    elsif item.is_reserved_by?(user)
      '<i class="reserved">You have already reserved this</i>'.html_safe
    elsif item.is_for_swap?
      link_to 'Propose a Trade', new_user_item_transaction_path(current_user, item), class:'button alert tiny'
    elsif item.is_looking_for?
      link_to 'Offer an Item', new_user_item_transaction_path(current_user, item), class:'button alert tiny'
    end
  end
end
