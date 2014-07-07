library robotlegs;

//-----------------------------------
// imports
//-----------------------------------

import 'dart:mirrors';
import 'dart:html' as dom;
import 'package:robotlegs_di/robotlegs_di.dart';
import "package:dotdotcommadot_messaging/dotdotcommadot_messaging.dart";

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
part 'framework/api/lifecycle_message.dart';
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
part 'framework/impl/rl_message_dispatcher.dart';
part 'framework/impl/object_processor.dart';
part 'framework/impl/pin.dart';
part 'framework/impl/robotlegs_injector.dart';
part 'framework/impl/safely_callback.dart';

//-----------------------------------
// Extensions
//-----------------------------------

// command center

part 'extensions/command_center/api/command_payload.dart';
part 'extensions/command_center/api/i_command.dart';
part 'extensions/command_center/api/i_command_executor.dart';
part 'extensions/command_center/api/i_command_mapping.dart';
part 'extensions/command_center/api/i_command_mapping_list.dart';
part 'extensions/command_center/api/i_command_trigger.dart';

part 'extensions/command_center/dsl/i_command_configurator.dart';
part 'extensions/command_center/dsl/i_command_mapper.dart';
part 'extensions/command_center/dsl/i_command_unmapper.dart';

part 'extensions/command_center/impl/command_executor.dart';
part 'extensions/command_center/impl/command_mapper.dart';
part 'extensions/command_center/impl/command_mapping.dart';
part 'extensions/command_center/impl/command_mapping_list.dart';
part 'extensions/command_center/impl/command_trigger_map.dart';
part 'extensions/command_center/impl/null_command_trigger.dart';

// context view

part 'extensions/context_view/context_view.dart';
part 'extensions/context_view/context_view_extension.dart';
part 'extensions/context_view/context_view_listener_config.dart';
part 'extensions/context_view/stage_sync_extension.dart';

// local event map

part 'extensions/local_event_map/api/i_event_map.dart';

// matching

part 'extensions/matching/instance_of_type.dart';
part 'extensions/matching/i_type_filter.dart';
part 'extensions/matching/i_type_matcher.dart';
part 'extensions/matching/i_type_matcher_factory.dart';
part 'extensions/matching/type_filter.dart';
part 'extensions/matching/type_matcher.dart';
part 'extensions/matching/type_matcher_error.dart';

// mediator map

part 'extensions/mediator_map/api/i_mediator.dart';
part 'extensions/mediator_map/api/i_mediator_map.dart';
part 'extensions/mediator_map/api/i_mediator_mapping.dart';

part 'extensions/mediator_map/dsl/i_mediator_configurator.dart';
part 'extensions/mediator_map/dsl/i_mediator_mapper.dart';
part 'extensions/mediator_map/dsl/i_mediator_unmapper.dart';

part 'extensions/mediator_map/impl/mediator_factory.dart';
part 'extensions/mediator_map/impl/mediator_manager.dart';
part 'extensions/mediator_map/impl/mediator_map.dart';
part 'extensions/mediator_map/impl/mediator_mapper.dart';
part 'extensions/mediator_map/impl/mediator_mapping.dart';
part 'extensions/mediator_map/impl/mediator_view_handler.dart';
part 'extensions/mediator_map/impl/null_mediator_unmapper.dart';

part 'extensions/mediator_map/mediator_map_extension.dart';

// message command map

part 'extensions/message_command_map/api/i_message_command_map.dart';

part 'extensions/message_command_map/impl/message_command_map.dart';
part 'extensions/message_command_map/impl/message_command_trigger.dart';

part 'extensions/message_command_map/message_command_map_extension.dart';

// message dispatcher

part 'extensions/message_dispatcher/message_dispatcher_extension.dart';

// view manager

part 'extensions/view_manager/api/i_view_handler.dart';
part 'extensions/view_manager/api/i_view_manager.dart';

part 'extensions/view_manager/impl/container_binding.dart';
part 'extensions/view_manager/impl/container_registry.dart';
part 'extensions/view_manager/impl/stage_crawler.dart';
part 'extensions/view_manager/impl/stage_observer.dart';
part 'extensions/view_manager/impl/view_manager.dart';

part 'extensions/view_manager/stage_crawler_extension.dart';
part 'extensions/view_manager/stage_observer_extension.dart';
part 'extensions/view_manager/view_manager_extension.dart';

// view processor map

part 'extensions/view_processor_map/api/i_view_processor_map.dart';
part 'extensions/view_processor_map/api/view_processor_map_error.dart';

part 'extensions/view_processor_map/dsl/i_view_processor_mapper.dart';
part 'extensions/view_processor_map/dsl/i_view_processor_mapping.dart';
part 'extensions/view_processor_map/dsl/i_view_processor_mapping_config.dart';
part 'extensions/view_processor_map/dsl/i_view_processor_unmapper.dart';

part 'extensions/view_processor_map/impl/i_view_processor_factory.dart';
part 'extensions/view_processor_map/impl/i_view_processor_view_handler.dart';
part 'extensions/view_processor_map/impl/null_processor.dart';
part 'extensions/view_processor_map/impl/null_view_processor_unmapper.dart';
part 'extensions/view_processor_map/impl/view_injection_processor.dart';
part 'extensions/view_processor_map/impl/view_processor_factory.dart';
part 'extensions/view_processor_map/impl/view_processor_map.dart';
part 'extensions/view_processor_map/impl/view_processor_mapper.dart';
part 'extensions/view_processor_map/impl/view_processor_mapping.dart';
part 'extensions/view_processor_map/impl/view_processor_view_handler.dart';

part 'extensions/view_processor_map/view_processor_map_extension.dart';