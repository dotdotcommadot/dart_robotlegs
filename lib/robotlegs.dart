library robotlegs;

//-----------------------------------
// imports
//-----------------------------------

import 'dart:mirrors';
import 'dart:async';
import 'dart:html';
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

// matching

part 'extensions/matching/i_type_filter.dart';
part 'extensions/matching/i_type_matcher.dart';

// context view

part 'extensions/contextview/context_view.dart';
part 'extensions/contextview/context_view_extension.dart';
part 'extensions/contextview/context_view_listener_config.dart';
part 'extensions/contextview/stage_sync_extension.dart';

// view manager

part 'extensions/viewmanager/api/i_view_handler.dart';
part 'extensions/viewmanager/api/i_view_manager.dart';

part 'extensions/viewmanager/impl/container_binding.dart';
part 'extensions/viewmanager/impl/container_registry.dart';
part 'extensions/viewmanager/impl/view_manager.dart';

part 'extensions/viewmanager/view_manager_extension.dart';

// view processor map

part 'extensions/viewprocessormap/api/i_view_processor_map.dart';

part 'extensions/viewprocessormap/dsl/i_view_processor_mapper.dart';
part 'extensions/viewprocessormap/dsl/i_view_processor_mapping.dart';
part 'extensions/viewprocessormap/dsl/i_view_processor_mapping_config.dart';
part 'extensions/viewprocessormap/dsl/i_view_processor_unmapper.dart';

part 'extensions/viewprocessormap/impl/i_view_processor_factory.dart';
part 'extensions/viewprocessormap/impl/view_processor_factory.dart';
part 'extensions/viewprocessormap/impl/view_processor_map.dart';

part 'extensions/viewprocessormap/view_processor_map_extension.dart';