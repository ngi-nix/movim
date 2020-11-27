<?php

use Movim\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddTimerToMessagesTable extends Migration
{
    public function up()
    {
        $this->schema->table('messages', function (Blueprint $table) {
            $table->integer('timer')->nullable();
        });
    }

    public function down()
    {
        $this->schema->table('messages', function (Blueprint $table) {
            $table->dropColumn('timer');
        });
    }
}
