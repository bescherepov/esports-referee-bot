module default {
  scalar type RefRole extending enum<"Ref", "GameRef", "GroupRef", "AdminRef", "MainRef", "BOSS", "DemoGuest">;
  scalar type TourStatus extending enum<Registering, Running, Finished>;
  scalar type MatchStatus extending enum<WaitingTime, NeedRef, WaitingStart,
  WaitingVerification, RunningMap1, RunningMap2, RunningMap3, RunningMap4, RunningMap5, RunningMap6, RunningMap7, Finished>;
  scalar type PrizeStatus extending enum<WaitingPrizeArrival, WaitingPlayer, Shipping, WaitingForm, Given>;

  scalar type MapCount extending enum<BO1, BO2, BO3, BO5, BO7>;

  scalar type RefGrade extending enum<NoGrade, Grade3, Grade2, Grade1>;

  scalar type TourStage extending enum<GroupStage, Playoffs>;
  scalar type TourGroupType extending enum<Robin, Swiss>;
  scalar type TourGroupDistrType extending enum<Random, RankEqual>;
  scalar type TourPlayoffType extending enum<SingleElim, DoubleElim>;

  scalar type MatchNetworkType extending enum<Online, Lan>;


  scalar type StudentID extending str {
    constraint regexp(r'[0-9]{2}[А-Я][0-9]{4}'); 
  }

  type Referee{
    required single name: str;
    vk: str;
    tg: str;
    grade: RefGrade {
      default := RefGrade.NoGrade;
    }
    joinedAt: cal::local_date {
      readonly := true;
    }
    refRole: RefRole {
      default := RefRole.Ref;
    }

    multi matches := .<matchRef;
    multi activitiesTournaments := .<tourActivityRef;
    multi records := .<recordActivityRef;
    multi activitiesCommon := .<commonActivityRef;

    multi externalTournaments: ExternalRefParticipation;

    property matches_count := count(.matches);
    property tour_gameRef_count := count(.<gameRef);
    property tour_count := count(.activitiesTournaments);
    property lan_count := count(.<refs_lan);
    property externalTournaments_count := count(.externalTournaments);
  }

  type Tournament {
    required name: str;
    game: Game;

    start_date: datetime;
    end_date: datetime;

    stage: TourStage {
      default := TourStage.GroupStage;
    }
    status: TourStatus {
      default := TourStatus.Registering;
    }

    challonge_url: str;
    posts_url: array<str>;
    registration_url: str;
    rules_url: str;

    single gameRef: Referee;
    multi refs: Referee;
    multi refs_lan: Referee;
    multi teams := .<tournamentParticipatingIn; 
    multi matches := .<matchTournament;
    multi incidents := .<incidentTournament;
  }

  type MatchTour {
    required matchTournament: Tournament;
    stage := .matchTournament.stage;
    matchType: MatchNetworkType {
      default := MatchNetworkType.Online;
    }
    matchRef: Referee;
    time: datetime;

    required team1: Team;
    required team2: Team;
    team1_name := .team1.name;
    team2_name := .team2.name;
    
    status: MatchStatus {
      default := MatchStatus.WaitingTime;
    }
    score: tuple<int16, int16>;
  }

  type Team {
    required tournamentParticipatingIn: Tournament;
    required name: str;
    multi players: Player;
  }

  type Player {
    required studentID: StudentID;
    institute: str;
    vk: str;
    tg: str;
    # tournaments := (select Tournament filter  .<players[is Team] );
    tourPrizes := .<playerToGetPrize;
  }

  type RefActivityRecord {
    game: Game;
    required recordActivityRef: Referee {
      on target delete delete source;
    }
    grade: int16 {
      constraint min_value(0);
      constraint max_value(10);
    }
    description: str;
  }

  type IncidentTour {
    required incidentTournament: Tournament {
      on target delete delete source;
    }
    required matchTour: MatchTour {
      on target delete delete source;
    }
    name: str;
    information: array<str>;
  }

  type RefActivityTour{
    required tournament: Tournament {
      on target delete delete source;
    }
    required tourActivityRef: Referee;
    roleOnTour := .tourActivityRef.refRole;
  }
  type RefActivityCommon {
    required commonActivityRef: Referee;
    description: str;
  }

  type Game {
    required name: str;
    multi tournaments := .<game;
  }
  
  type Ban {
    required studentID: StudentID;
    until: cal::local_date;
  }

  type PrizeTour{
    required tournament: Tournament;
    required playerToGetPrize: Player;
    required place: int16;
    required prizeName: Prize;
  }

  type Prize {
    required name: str;
    required count: int16 {
      constraint min_value(0);
    }
  }

  type ExternalRefParticipation {
    required tourName: str;
    required roleOnTour: str;
  }
  
}
