library robotlegs;

//-----------------------------------
// imports
//-----------------------------------

import 'dart:mirrors';
import 'dart:async';
import 'package:robotlegs_di/robotlegs_di.dart';

//-----------------------------------
// Bundles
//-----------------------------------

part 'bundles/mvcs/command.dart';
part 'bundles/mvcs/mediator.dart';
part 'bundles/mvcs/mvcs_bundle.dart';

//-----------------------------------
// Framework
//-----------------------------------

part 'framework/api/i_bundle.dart';
part 'framework/api/i_config.dart';
part 'framework/api/i_context.dart';
part 'framework/api/i_extension.dart';
part 'framework/api/i_guard.dart';
part 'framework/api/i_hook.dart';
part 'framework/api/i_lifecycle.dart';
part 'framework/api/i_logger.dart';
part 'framework/api/i_log_target.dart';
part 'framework/api/i_matcher.dart';
part 'framework/api/lifecycle_error.dart';
part 'framework/api/lifecycle_event.dart';
part 'framework/api/lifecycle_state.dart';
part 'framework/api/log_level.dart';
part 'framework/api/pin_event.dart';

part 'framework/impl/apply_hooks.dart';
part 'framework/impl/config_manager.dart';
part 'framework/impl/context.dart';
part 'framework/impl/extension_installer.dart';
part 'framework/impl/guards_approve.dart';
part 'framework/impl/lifecycle.dart';
part 'framework/impl/lifecycle_transition.dart';
part 'framework/impl/logger.dart';
part 'framework/impl/log_manager.dart';
part 'framework/impl/message_dispatcher.dart';
part 'framework/impl/object_processor.dart';
part 'framework/impl/pin.dart';
part 'framework/impl/robotlegs_injector.dart';
part 'framework/impl/safely_callback.dart';

//-----------------------------------
// Extensions
//-----------------------------------

// command center

part 'extensions/commandcenter/api/command_payload.dart';
part 'extensions/commandcenter/api/i_command.dart';
part 'extensions/commandcenter/api/i_command_executor.dart';
part 'extensions/commandcenter/api/i_command_mapping.dart';
part 'extensions/commandcenter/api/i_command_mapping_list.dart';
part 'extensions/commandcenter/api/i_command_trigger.dart';

part 'extensions/commandcenter/dsl/i_command_configurator.dart';
part 'extensions/commandcenter/dsl/i_command_mapper.dart';
part 'extensions/commandcenter/dsl/i_command_unmapper.dart';

part 'extensions/commandcenter/impl/command_executor.dart';
part 'extensions/commandcenter/impl/command_mapper.dart';
part 'extensions/commandcenter/impl/command_mapping.dart';
part 'extensions/commandcenter/impl/command_mapping_list.dart';
part 'extensions/commandcenter/impl/command_trigger_map.dart';
part 'extensions/commandcenter/impl/null_command_trigger.dart';

// mediator map

part 'extensions/mediatormap/api/i_mediator.dart';

// local event map

part 'extensions/localeventmap/api/i_event_map.dart';
part 'extensions/localeventmap/api/i_event_dispatcher.dart';

// context view

part 'extensions/contextview/context_view_listener_config.dart';
part 'extensions/contextview/context_view.dart';

// view manager

part 'extensions/viewmanager/api/i_view_manager.dart';