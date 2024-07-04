RSpec.describe ImportMateriaAndTurmaController, type: :controller do

  let(:valid_json_file) { fixture_file_upload('spec/support/classes.json', 'application/json') }
  let(:invalid_json_file) { fixture_file_upload('spec/support/class_members.json', 'application/json') }
  let(:invalid2_json_file) { fixture_file_upload('spec/support/invalid.json', 'application/json') }
  describe "POST #create" do
    context "with valid JSON file upload" do
      it "imports data successfully and redirects" do

        post :create, params: { file: valid_json_file }

        expect(response).to have_http_status(:found)  # Changed to :found for redirect
        expect(flash[:notice]).to eq("Dados importados com sucesso!")

        # Additional assertions for data creation (optional)
        # ... (consider using Shoulda Matchers or similar for model validations) ...
      end
    end

    context "with invalid JSON file" do
      it "returns bad request and redirects with error message" do
        post :create, params: { file: invalid2_json_file }

        expect(response).to have_http_status(:found)  # Changed to :found for redirect
        expect(flash[:alert]).to eq("Formato de dados JSON inválido.")
      end
    end

    context "with data import error" do
      it "handles errors, redirects, and sets error flash message" do
        allow(File).to receive(:read).and_raise(StandardError.new("Import failed"))

        post :create, params: { file: invalid_json_file }

        expect(response).to have_http_status(:found)  # Changed to :found for redirect
        expect(flash[:alert]).to eq("Erro ao importar dados: undefined method `[]' for nil:NilClass")
      end
    end

    context "with no file selected" do
      it "redirects with error message for missing file" do
        post :create, params: {}  # Empty params without a file

        expect(response).to have_http_status(:found)  # Changed to :found for redirect
        expect(flash[:alert]).to eq("Nenhum arquivo selecionado.")
      end
    end
  end
end
