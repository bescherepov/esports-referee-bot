CREATE MIGRATION m17rwugubxf7y4as6ypqmp5xivyn3ye76pqq22q775xmcefygt2ebq
    ONTO initial
{
  CREATE SCALAR TYPE default::StudentID EXTENDING std::str {
      CREATE CONSTRAINT std::regexp('[0-9]{2}[А-Я][0-9]{4}');
  };
  CREATE TYPE default::Ban {
      CREATE REQUIRED PROPERTY studentID: default::StudentID;
      CREATE PROPERTY until: cal::local_date;
  };
  CREATE TYPE default::ExternalRefParticipation {
      CREATE REQUIRED PROPERTY roleOnTour: std::str;
      CREATE REQUIRED PROPERTY tourName: std::str;
  };
  CREATE SCALAR TYPE default::RefGrade EXTENDING enum<NoGrade, Grade3, Grade2, Grade1>;
  CREATE SCALAR TYPE default::RefRole EXTENDING enum<Ref, GameRef, GroupRef, AdminRef, MainRef, BOSS, DemoGuest>;
  CREATE TYPE default::Referee {
      CREATE MULTI LINK externalTournaments: default::ExternalRefParticipation;
      CREATE PROPERTY externalTournaments_count := (std::count(.externalTournaments));
      CREATE PROPERTY refRole: default::RefRole {
          SET default := (default::RefRole.Ref);
      };
      CREATE PROPERTY grade: default::RefGrade {
          SET default := (default::RefGrade.NoGrade);
      };
      CREATE PROPERTY joinedAt: cal::local_date {
          SET readonly := true;
      };
      CREATE REQUIRED PROPERTY name: std::str;
      CREATE PROPERTY tg: std::str;
      CREATE PROPERTY vk: std::str;
  };
  CREATE TYPE default::Game {
      CREATE REQUIRED PROPERTY name: std::str;
  };
  CREATE TYPE default::RefActivityRecord {
      CREATE LINK game: default::Game;
      CREATE REQUIRED LINK recordActivityRef: default::Referee {
          ON TARGET DELETE DELETE SOURCE;
      };
      CREATE PROPERTY description: std::str;
      CREATE PROPERTY grade: std::int16 {
          CREATE CONSTRAINT std::max_value(10);
          CREATE CONSTRAINT std::min_value(0);
      };
  };
  CREATE SCALAR TYPE default::TourStage EXTENDING enum<GroupStage, Playoffs>;
  CREATE SCALAR TYPE default::TourStatus EXTENDING enum<Registering, Running, Finished>;
  CREATE TYPE default::Tournament {
      CREATE LINK game: default::Game;
      CREATE PROPERTY stage: default::TourStage {
          SET default := (default::TourStage.GroupStage);
      };
      CREATE MULTI LINK refs_lan: default::Referee;
      CREATE SINGLE LINK gameRef: default::Referee;
      CREATE MULTI LINK refs: default::Referee;
      CREATE PROPERTY challonge_url: std::str;
      CREATE PROPERTY end_date: std::datetime;
      CREATE REQUIRED PROPERTY name: std::str;
      CREATE PROPERTY posts_url: array<std::str>;
      CREATE PROPERTY registration_url: std::str;
      CREATE PROPERTY rules_url: std::str;
      CREATE PROPERTY start_date: std::datetime;
      CREATE PROPERTY status: default::TourStatus {
          SET default := (default::TourStatus.Registering);
      };
  };
  ALTER TYPE default::Game {
      CREATE MULTI LINK tournaments := (.<game);
  };
  CREATE TYPE default::IncidentTour {
      CREATE REQUIRED LINK incidentTournament: default::Tournament {
          ON TARGET DELETE DELETE SOURCE;
      };
      CREATE PROPERTY information: array<std::str>;
      CREATE PROPERTY name: std::str;
  };
  ALTER TYPE default::Tournament {
      CREATE MULTI LINK incidents := (.<incidentTournament);
  };
  CREATE SCALAR TYPE default::MatchNetworkType EXTENDING enum<Online, Lan>;
  CREATE SCALAR TYPE default::MatchStatus EXTENDING enum<WaitingTime, NeedRef, WaitingStart, WaitingVerification, RunningMap1, RunningMap2, RunningMap3, RunningMap4, RunningMap5, RunningMap6, RunningMap7, Finished>;
  CREATE TYPE default::MatchTour {
      CREATE LINK matchRef: default::Referee;
      CREATE REQUIRED LINK matchTournament: default::Tournament;
      CREATE PROPERTY stage := (.matchTournament.stage);
      CREATE PROPERTY matchType: default::MatchNetworkType {
          SET default := (default::MatchNetworkType.Online);
      };
      CREATE PROPERTY score: tuple<std::int16, std::int16>;
      CREATE PROPERTY status: default::MatchStatus {
          SET default := (default::MatchStatus.WaitingTime);
      };
      CREATE PROPERTY time: std::datetime;
  };
  ALTER TYPE default::IncidentTour {
      CREATE REQUIRED LINK matchTour: default::MatchTour {
          ON TARGET DELETE DELETE SOURCE;
      };
  };
  ALTER TYPE default::Referee {
      CREATE MULTI LINK matches := (.<matchRef);
      CREATE PROPERTY matches_count := (std::count(.matches));
  };
  ALTER TYPE default::Tournament {
      CREATE MULTI LINK matches := (.<matchTournament);
  };
  CREATE TYPE default::Team {
      CREATE REQUIRED PROPERTY name: std::str;
      CREATE REQUIRED LINK tournamentParticipatingIn: default::Tournament;
  };
  ALTER TYPE default::MatchTour {
      CREATE REQUIRED LINK team1: default::Team;
      CREATE PROPERTY team1_name := (.team1.name);
      CREATE REQUIRED LINK team2: default::Team;
      CREATE PROPERTY team2_name := (.team2.name);
  };
  CREATE TYPE default::Player {
      CREATE PROPERTY institute: std::str;
      CREATE REQUIRED PROPERTY studentID: default::StudentID;
      CREATE PROPERTY tg: std::str;
      CREATE PROPERTY vk: std::str;
  };
  CREATE TYPE default::Prize {
      CREATE REQUIRED PROPERTY count: std::int16 {
          CREATE CONSTRAINT std::min_value(0);
      };
      CREATE REQUIRED PROPERTY name: std::str;
  };
  CREATE TYPE default::PrizeTour {
      CREATE REQUIRED LINK playerToGetPrize: default::Player;
      CREATE REQUIRED LINK prizeName: default::Prize;
      CREATE REQUIRED LINK tournament: default::Tournament;
      CREATE REQUIRED PROPERTY place: std::int16;
  };
  ALTER TYPE default::Player {
      CREATE LINK tourPrizes := (.<playerToGetPrize);
  };
  ALTER TYPE default::Team {
      CREATE MULTI LINK players: default::Player;
  };
  CREATE TYPE default::RefActivityCommon {
      CREATE REQUIRED LINK commonActivityRef: default::Referee;
      CREATE PROPERTY description: std::str;
  };
  ALTER TYPE default::Referee {
      CREATE MULTI LINK activitiesCommon := (.<commonActivityRef);
      CREATE MULTI LINK records := (.<recordActivityRef);
  };
  CREATE TYPE default::RefActivityTour {
      CREATE REQUIRED LINK tourActivityRef: default::Referee;
      CREATE PROPERTY roleOnTour := (.tourActivityRef.refRole);
      CREATE REQUIRED LINK tournament: default::Tournament {
          ON TARGET DELETE DELETE SOURCE;
      };
  };
  ALTER TYPE default::Referee {
      CREATE MULTI LINK activitiesTournaments := (.<tourActivityRef);
      CREATE PROPERTY tour_count := (std::count(.activitiesTournaments));
      CREATE PROPERTY lan_count := (std::count(.<refs_lan));
      CREATE PROPERTY tour_gameRef_count := (std::count(.<gameRef));
  };
  ALTER TYPE default::Tournament {
      CREATE MULTI LINK teams := (.<tournamentParticipatingIn);
  };
  CREATE SCALAR TYPE default::MapCount EXTENDING enum<BO1, BO2, BO3, BO5, BO7>;
  CREATE SCALAR TYPE default::PrizeStatus EXTENDING enum<WaitingPrizeArrival, WaitingPlayer, Shipping, WaitingForm, Given>;
  CREATE SCALAR TYPE default::TourGroupDistrType EXTENDING enum<Random, RankEqual>;
  CREATE SCALAR TYPE default::TourGroupType EXTENDING enum<Robin, Swiss>;
  CREATE SCALAR TYPE default::TourPlayoffType EXTENDING enum<SingleElim, DoubleElim>;
};
