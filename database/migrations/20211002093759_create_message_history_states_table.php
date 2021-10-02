<?php

use Movim\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateMessageHistoryStatesTable extends Migration
{
    public function up()
    {
        $this->schema->create('message_history_states', function (Blueprint $table) {
            $table->integer('message_mid')->unsigned()->nullable();
            $table->string('user_id', 64);
            $table->string('jidfrom', 256);
            $table->timestamps();

            $table->foreign('message_mid')->references('mid')
                  ->on('messages')->onDelete('cascade');

            $table->unique(['user_id', 'jidfrom']);
        });
    }

    public function down()
    {
        $this->schema->drop('message_history_states');
    }
}
