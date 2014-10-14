
function Skinner:FramesResized_TrainerUI()
    if not self.db.profile.ClassTrainer then return end

    self:removeRegions(_G["ClassTrainerFrame_MidTextures"])
    self:removeRegions(_G["ClassTrainerListScrollFrame_MidTextures"])  

    self:moveObject(_G["ClassTrainerTrainButton"], nil, nil, "+", 20)
    self:moveObject(_G["ClassTrainerCancelButton"], nil, nil, "+", 20)

end
