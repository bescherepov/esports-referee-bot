CREATE MIGRATION m1oqlxhcnjy3ddkdsjy2sx5ig3t6lzudyjebbtv2w6ylt75tgrp3rq
    ONTO initial
{
  CREATE TYPE default::TourMatch {
      CREATE REQUIRED PROPERTY name: std::str;
  };
  CREATE SCALAR TYPE default::TourStatus EXTENDING enum<Registering, Running, Finished>;
  CREATE TYPE default::Tournament {
      CREATE REQUIRED PROPERTY end_date: std::datetime;
      CREATE REQUIRED PROPERTY name: std::str;
      CREATE REQUIRED PROPERTY start_date: std::datetime;
      CREATE REQUIRED PROPERTY status: default::TourStatus;
      CREATE REQUIRED PROPERTY url: std::str;
  };
};
