//  ContentManager.swift
//  Model
//
//  Created by CHH51 on 12/7/18.

import Foundation

public extension Notification.Name {
    public static let Model_ContentManager_Change = Notification.Name("com.chh51.layoutExample.Model.ContentManager.change")
}

public final class ContentManager {
    
    public static func addChapter( _ chapter_: Chapter ) {
        Chapter.addChapter( chapter_ )
        self._notifyAdd() 
    }
    public static func addImage( _ image_: Image ) {
        Image.addImage( image_ )
        self._notifyAdd()
    }
    public static func addMovie( _ movie_: Movie ) {
        Movie.addMovie( movie_ )
        self._notifyAdd()
    }
    public static func addStory( _ story_: Story ) {
        Story.addStory( story_ )
        self._notifyAdd()
    }
    public static func addText( _ text_: Text ) {
        Text.addText( text_ )
        self._notifyAdd()
    }
    public static func deleteBy( itemId: Int ) {
        if let contentIndex = ContentIndex.singleton.getBy(itemId: itemId ) {
            switch contentIndex.itemContentType {
            case .chapter:
                preconditionFailure("not implemented")
            case .image:
                if let image = Image.getById( itemId ) {
                    self.deleteImage( image )
                }
            case .movie:
                if let movie = Movie.getById( itemId ) {
                    self.deleteMovie( movie )
                }
            case .story:
                preconditionFailure("not implemented")
            case .text:
                if let text = Text.getById( itemId ) {
                    self.deleteText( text )
                }
            case .unknown:
                preconditionFailure("invalid")
            }
        }
    }
    public static func deleteImage( _ image_: Image ) {
        self._removeParentReference(uniqueId_: image_.uniqueId )
        Image.removeById( image_.uniqueId )
        self._notifyDelete()
    }
    public static func deleteMovie( _ movie_: Movie ) {
        self._removeParentReference(uniqueId_: movie_.uniqueId )
        Movie.removeById( movie_.uniqueId )
        self._notifyDelete()
    }
    public static func deleteText( _ text_: Text ) {
        self._removeParentReference(uniqueId_: text_.uniqueId )
        Text.removeById( text_.uniqueId )
        self._notifyDelete()
    }
    // MARK: private
    private init() {}
    
    private static func _notifyAdd() {
        let notify = Notification(name: Notification.Name.Model_ContentManager_Change )
        NotificationQueue.default.enqueue( notify, postingStyle: .whenIdle, coalesceMask: .onName, forModes: nil )
    }
    private static func _notifyDelete() {
        let notify = Notification(name: Notification.Name.Model_ContentManager_Change )
        NotificationQueue.default.enqueue( notify, postingStyle: .whenIdle, coalesceMask: .onName, forModes: nil )
    }
    private static func _removeParentReference( uniqueId_: Int ) {
        if let contentIndex = ContentIndex.singleton.getBy(itemId: uniqueId_ ) {
            if ( contentIndex.parentUniqueId != nil ) {
                if let parentContentIndex = ContentIndex.singleton.getBy(itemId: contentIndex.parentUniqueId! ) {
                    switch parentContentIndex.itemContentType {
                    case .chapter:
                        let chapter = Chapter.getById( parentContentIndex.itemUniqueId )!
                        if let itemIdx = chapter.aUniqueId.firstIndex(of: uniqueId_ ) {
                            chapter.aUniqueId.remove(at: itemIdx )
                        }
                    case .story:
                        let story = Story.getById( parentContentIndex.itemUniqueId )!
                        if let itemIdx = story.aChapterId.firstIndex(of: uniqueId_ ) {
                            story.aChapterId.remove(at: itemIdx )
                        }
                    default:
                        break
                    }
                }
            }
            contentIndex.set(parentId: nil )
        }
    }
}
