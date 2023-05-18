<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateRostersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('rosters', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->date('date');
            $table->string('day');
            $table->integer('week');
            $table->string('month');
            $table->integer('time_in');
            $table->integer('time_out');
            $table->integer('total_hour');
            $table->double('rate', 5, 2);
            $table->timestamps();

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        // Schema::table('rosters', function (Blueprint $table) {
        //     $table->dropForeign(['user_id']);
        // });
        Schema::dropIfExists('rosters');
        
    }
}
