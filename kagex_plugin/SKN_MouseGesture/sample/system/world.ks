@if exp="typeof(global.world_object) == 'undefined'"
@iscript

KAGLoadScript('world.tjs');

kag.addPlugin(global.world_object = new KAGWorldPlugin(kag));
if (kag.debugLevel >= tkdlSimple) {
    dm("���[���h���ݒ芮��");
}

// �����G�\���m�F�p�E�C���h�E�@�\
if (debugWindowEnabled) {
	KAGLoadScript('standview.tjs');
}

@endscript
@endif

@return
