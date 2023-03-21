class Target < ISM::Software

    def prepare
        super

        fileDeleteLine("#{buildDirectoryPath(false)}install.sh",162)
        fileDeleteLine("#{buildDirectoryPath(false)}install.sh",162)
        fileDeleteLine("#{buildDirectoryPath(false)}install.sh",162)
        fileReplaceTextAtLineNumber("#{buildDirectoryPath(false)}CPP/7zip/Common/StreamObjects.cpp", "return E_FAIL;","if(_buffer == nullptr || _size == _pos) return E_FAIL;\nreturn E_FAIL;",161)
    end

    def build
        super

        makeSource(["all3"],buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource(["DEST_DIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","DEST_HOME=/usr","DEST_MAN=/usr/share/man","DEST_SHARE_DOC=/usr/share/doc/p7zip-17.04","install"],buildDirectoryPath)
    end

end
