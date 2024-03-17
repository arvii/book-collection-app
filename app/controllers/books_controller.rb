class BooksController < ApplicationController
  def index
    @books = Book.filter_by_title(params[:title])
                .filter_by_year(params[:year_of_publication])
                .filter_by_author_id(params[:author_id])
                .filter_by_tag_id(params[:tag_id])
                .sorted(params[:sort], params[:direction])
                .page(params[:page]).per(20)

    @authors = Author.all
    @tags = Tag.all
  end
end
