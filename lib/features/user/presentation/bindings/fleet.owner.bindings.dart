 import 'package:drivn_app/features/user/data/api/fleet.owner.api.dart';
import 'package:drivn_app/features/user/domain/repositories/fleet.owner.repo.dart';
import 'package:drivn_app/features/user/domain/usecases/fleet.owner/create.dart';
import 'package:drivn_app/features/user/domain/usecases/fleet.owner/verify.fleetOwner.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/fleet.owner.dart';
import '../../data/remote/fleet.owner.db.dart';
import '../../data/repositories/fleet.owner.repo.impl.dart';

class FleetOwnerBindings {
  final fleetOwnerAPI = ChangeNotifierProvider<FleetOwnerAPI>(
    create: (context) => FleetOwnerAPI(),
  );
  final fleetOwnerDB = ChangeNotifierProxyProvider<FleetOwnerAPI, FleetOwnerDB>(
    create: (context) => FleetOwnerDBImpl.empty(),
    update: (context, api, previous) => FleetOwnerDBImpl(api),
  );

  final fleetOwnerRepo =
      ChangeNotifierProxyProvider<FleetOwnerDB, FleetOwnerRepo>(
    create: (context) => FleetOwnerRepoImpl.empty(),
    update: (context, db, previous) => FleetOwnerRepoImpl(db),
  );

  final postFleetOwner =
      ChangeNotifierProxyProvider<FleetOwnerRepo, PostUseCase>(
    create: (context) => PostUseCase.empty(),
    update: (context, fleetOwnerRepo, previous) => PostUseCase(fleetOwnerRepo),
  );

final verifyFleetOwner =
      ChangeNotifierProxyProvider<FleetOwnerRepo, VerifyFleetOwner>(
    create: (context) => VerifyFleetOwner.empty(),
    update: (context, fleetOwnerRepo, previous) => VerifyFleetOwner(fleetOwnerRepo),
  );

  final fleetOwnerProvider =
      ChangeNotifierProxyProvider<PostUseCase, FleetOwnerProvider>(
    create: (context) => FleetOwnerProvider.empty(),
    update: (context, postUseCase, previous) => FleetOwnerProvider(postUseCase,context.read<VerifyFleetOwner>()),
  );
}
