require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe PicturesController do

  # This should return the minimal set of attributes required to create a valid
  # Picture. As you add validations to Picture, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "item" => "" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PicturesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all pictures as @pictures" do
      picture = Picture.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:pictures)).to eq([picture])
    end
  end

  describe "GET show" do
    it "assigns the requested picture as @picture" do
      picture = Picture.create! valid_attributes
      get :show, {:id => picture.to_param}, valid_session
      expect(assigns(:picture)).to eq(picture)
    end
  end

  describe "GET new" do
    it "assigns a new picture as @picture" do
      get :new, {}, valid_session
      expect(assigns(:picture)).to be_a_new(Picture)
    end
  end

  describe "GET edit" do
    it "assigns the requested picture as @picture" do
      picture = Picture.create! valid_attributes
      get :edit, {:id => picture.to_param}, valid_session
      expect(assigns(:picture)).to eq(picture)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Picture" do
        expect {
          post :create, {:picture => valid_attributes}, valid_session
        }.to change(Picture, :count).by(1)
      end

      it "assigns a newly created picture as @picture" do
        post :create, {:picture => valid_attributes}, valid_session
        expect(assigns(:picture)).to be_a(Picture)
        expect(assigns(:picture)).to be_persisted
      end

      it "redirects to the created picture" do
        post :create, {:picture => valid_attributes}, valid_session
        expect(response).to redirect_to(Picture.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved picture as @picture" do
        # Trigger the behavior that occurs when invalid params are submitted
        Picture.any_instance.stub(:save).and_return(false)
        post :create, {:picture => { "item" => "invalid value" }}, valid_session
        expect(assigns(:picture)).to be_a_new(Picture)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Picture.any_instance.stub(:save).and_return(false)
        post :create, {:picture => { "item" => "invalid value" }}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested picture" do
        picture = Picture.create! valid_attributes
        # Assuming there are no other pictures in the database, this
        # specifies that the Picture created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Picture).to receive(:update).with({ "item" => "" })
        put :update, {:id => picture.to_param, :picture => { "item" => "" }}, valid_session
      end

      it "assigns the requested picture as @picture" do
        picture = Picture.create! valid_attributes
        put :update, {:id => picture.to_param, :picture => valid_attributes}, valid_session
        expect(assigns(:picture)).to eq(picture)
      end

      it "redirects to the picture" do
        picture = Picture.create! valid_attributes
        put :update, {:id => picture.to_param, :picture => valid_attributes}, valid_session
        expect(response).to redirect_to(picture)
      end
    end

    describe "with invalid params" do
      it "assigns the picture as @picture" do
        picture = Picture.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Picture.any_instance.stub(:save).and_return(false)
        put :update, {:id => picture.to_param, :picture => { "item" => "invalid value" }}, valid_session
        expect(assigns(:picture)).to eq(picture)
      end

      it "re-renders the 'edit' template" do
        picture = Picture.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Picture.any_instance.stub(:save).and_return(false)
        put :update, {:id => picture.to_param, :picture => { "item" => "invalid value" }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested picture" do
      picture = Picture.create! valid_attributes
      expect {
        delete :destroy, {:id => picture.to_param}, valid_session
      }.to change(Picture, :count).by(-1)
    end

    it "redirects to the pictures list" do
      picture = Picture.create! valid_attributes
      delete :destroy, {:id => picture.to_param}, valid_session
      expect(response).to redirect_to(pictures_url)
    end
  end

end
