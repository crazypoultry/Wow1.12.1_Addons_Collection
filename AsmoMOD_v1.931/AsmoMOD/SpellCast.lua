-- Hook Cast Functions
AsmoMODOldUseAction = UseAction;
function UseAction(slot, checkCursor, onSelf)
	AsmoMOD_IDCheck(slot);
	ExecuteCheck();
	AsmoMODOldUseAction(slot, checkCursor, onSelf)
end

-- Hook Camera Zoom
AsmoMODoldCameraZoomIn = CameraZoomIn;
function CameraZoomIn(value)
	ExecuteCheck();
	AsmoMODoldCameraZoomIn(value);
end

AsmoMODoldCameraZoomOut = CameraZoomOut;
function CameraZoomOut(value)
	ExecuteCheck();
	AsmoMODoldCameraZoomOut(value);
end