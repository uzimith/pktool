module Pktool
  module Command
    class Party < Thor
      desc "list", "一覧を表示する"
      def list
        puts "list"
      end

      desc "create", "パーティを構築する"
      def create
        puts "create"
      end

      desc "edit", "パーティを変更する"
      def edit
        puts "edit"
      end

    end
  end
end
