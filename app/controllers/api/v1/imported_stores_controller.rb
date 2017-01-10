class Api::V1::ImportedStoresController < ApiController

  skip_before_action :authenticate_request, only: :update_imported_stores

  def create
    @imported_store = ImportedStore.create

    render json: @imported_store
  end

  def update_imported_stores
    @imported_store = ImportedStore.find(params[:id])
    @imported_store.update_attributes(imported: true)
    @imported_store.save
  end

  def last_import_status
    @imported_store = ImportedStore.last

    if @imported_store
      render json: @imported_store
    else
      render json: {imported: true}
    end
  end

end
